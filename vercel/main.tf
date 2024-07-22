resource "vercel_project" "shouldideploytoday" {
  name = "shouldideploytoday"

  install_command  = "npm install"
  build_command    = "npm run build"
  output_directory = ".next"
}
