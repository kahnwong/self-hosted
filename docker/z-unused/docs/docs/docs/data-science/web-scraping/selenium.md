---
title: Selenium
---

```python
from selenium import webdriver
from selenium.webdriver.firefox.options import Options

profile = webdriver.FirefoxProfile()
profile.set_preference("dom.webnotifications.enabled", False)
options = Options()
options.headless = False # True
driver = webdriver.Firefox(
    profile, log_path='/dev/null', options=options)

driver.get(URL)

driver.find_element_by_xpath(
                "//*[@id='email']")
```
