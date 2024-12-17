resource "vercel_project" "gitreceipt" {
  name = "gitreceipt"

  framework = "nextjs"
}
resource "vercel_project_domain" "gitreceipt" {
  project_id = vercel_project.gitreceipt.id
  domain     = "gitreceipt.karnwong.me"
}

resource "vercel_project" "shouldideploytoday" {
  name = "shouldideploytoday"

  framework = "nextjs"
}
resource "vercel_project_domain" "shouldideploytoday" {
  project_id = vercel_project.shouldideploytoday.id
  domain     = "shouldideploytoday.karnwong.me"
}

resource "vercel_project" "transform" {
  name = "transform"

  framework = "nextjs"
}
resource "vercel_project_domain" "transform" {
  project_id = vercel_project.transform.id
  domain     = "transform.karnwong.me"
}
