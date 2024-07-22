resource "vercel_project" "shouldideploytoday" {
  name = "shouldideploytoday"

  framework = "nextjs"
}
resource "vercel_project_domain" "shouldideploytoday" {
  project_id = vercel_project.shouldideploytoday.id
  domain     = "shouldideploytoday.karnwong.me"
}
