#!/usr/bin/env python3

import glob
import os
import sys

DEPLOYMENTS_DIR = os.path.normpath(
    os.path.join(os.path.dirname(__file__), "../../../specs/deployments")
)

GREEN = "\033[32m"
RED = "\033[31m"
RESET = "\033[0m"


def strip_comment(line):
    in_single = False
    in_double = False

    for index, char in enumerate(line):
        if char == "'" and not in_double:
            in_single = not in_single
        elif char == '"' and not in_single:
            in_double = not in_double
        elif char == "#" and not in_single and not in_double:
            return line[:index]

    return line


def parse_scalar(value):
    value = value.strip()

    if value in ("", "|", ">"):
        return None

    lower_value = value.lower()
    if lower_value == "true":
        return True
    if lower_value == "false":
        return False
    if lower_value in ("null", "~"):
        return None

    if (
        (value.startswith('"') and value.endswith('"'))
        or (value.startswith("'") and value.endswith("'"))
    ):
        return value[1:-1]

    return value


def top_level_items(path):
    items = []

    with open(path, "r", encoding="utf-8") as file:
        for line in file:
            clean_line = strip_comment(line).rstrip()
            if not clean_line.strip():
                continue
            if clean_line.lstrip() != clean_line:
                continue
            if ":" not in clean_line:
                continue

            key, value = clean_line.split(":", 1)
            key = key.strip()
            if key.startswith("-") or not key:
                continue

            items.append((key, parse_scalar(value)))

    return items


def deployment_info(path):
    items = top_level_items(path)
    values = dict(items)
    keys = [key for key, _ in items]

    name = values.get("name")
    kind = values.get("kind")

    if kind == "Deployment":
        display_kind = "deployment"
    elif kind == "StatefulSet":
        display_kind = "statefulset"
    elif "cnpg" in values:
        display_kind = "cloudnative-pg"
    elif keys[:2] == ["name", "containers"]:
        display_kind = "knative"
    else:
        return None

    if not name:
        name = os.path.splitext(os.path.basename(path))[0]

    kube_green = None
    if display_kind == "deployment":
        kube_green = bool(values.get("kubeGreen", False))

    return name, display_kind, kube_green


def kube_green_text(value, color=False):
    if value is None:
        return "NULL"
    if value:
        text = "true"
        return f"{GREEN}{text}{RESET}" if color else text
    text = "false"
    return f"{RED}{text}{RESET}" if color else text


def kube_green_sort_value(value):
    if value is None:
        return 0
    if value is False:
        return 1
    return 2


def print_ascii_table(rows):
    headers = ["Name", "Kind", "kubeGreen"]
    use_color = sys.stdout.isatty()
    table_rows = [
        (
            [name, kind, kube_green_text(kube_green)],
            [name, kind, kube_green_text(kube_green, color=use_color)],
        )
        for name, kind, kube_green in rows
    ]
    widths = [len(header) for header in headers]

    for plain_row, _ in table_rows:
        for index, cell in enumerate(plain_row):
            widths[index] = max(widths[index], len(cell))

    separator = "+" + "+".join("-" * (width + 2) for width in widths) + "+"

    def print_row(plain_row, display_row):
        cells = []
        for index, cell in enumerate(display_row):
            padding = widths[index] - len(plain_row[index])
            cells.append(f" {cell}{' ' * padding} ")
        print("|" + "|".join(cells) + "|")

    print(separator)
    print_row(headers, headers)
    print(separator)
    for plain_row, display_row in table_rows:
        print_row(plain_row, display_row)
    print(separator)


def main():
    rows = []
    pattern = os.path.join(DEPLOYMENTS_DIR, "*", "*.yaml")

    for path in sorted(glob.glob(pattern)):
        info = deployment_info(path)
        if info is not None:
            rows.append(info)

    rows.sort(key=lambda row: (row[1], kube_green_sort_value(row[2])))
    print_ascii_table(rows)


if __name__ == "__main__":
    main()
