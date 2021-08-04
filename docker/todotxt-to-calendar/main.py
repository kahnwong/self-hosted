from utils.utils import *


if __name__ == "__main__":
    todos = parse_todos()
    calendar = return_calendar_object()

    ### clear entries
    print('clearing entries...')
    for i in calendar.events():
        i.delete()

    ### add todo to caldav
    for todo in todos:
        vcal = create_vcal(todo)
        calendar.save_event(vcal)

        task_name = todo['todo']
        print(f'added: {task_name}')
