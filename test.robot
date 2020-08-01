*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem

*** Test Cases ***
Check Result
    Open Browser
    ...  url=https://freiburg.corona-ergebnis.de/
    ...  browser=Chrome
    ...  remote_url=http://127.0.0.1:4444/wd/hub

    Remove Popup

    Wait Until Page Contains Element  xpath://input[@id="OrderNumber"]

    Input Text  xpath://input[@id="OrderNumber"]    ${orderNo}
    Input Text  xpath://input[@id="date"]           ${birth}}
    Input Text  xpath://input[@id="ZipCode"]        ${zipCode}

    Submit Form

    Wait Until Page Contains Element  xpath://h1[text() = "Ihr Ergebnis für Ihren Auftrag "]
    Wait Until Page Contains Element  xpath://div[contains(@class, "well")]
    ${text}=  Get Text  xpath://div[contains(@class, "well")]

    Close Browser

    Append To File  result.txt  ${text}

*** Keywords ***
Remove Popup
    Wait Until Page Contains Element  xpath://*[contains(@class, "csa-popup")]//a[@title = "Close"]
    ${closeLocator}=  Set Variable  xpath://*[contains(@class, "csa-popup")]//a[@title = "Close"]

    ${result}=  Run Keyword And Ignore Error  Element Should Be Visible  ${closeLocator}
    Run Keyword If  "${result[0]}" == "PASS"  Click Element  ${closeLocator}

Open Browser
    [Arguments]
    ...  ${url}
    ...  ${browser}
    ...  ${alias}=None
    ...  ${remote_url}=False
    ...  ${desired_capabilities}=None
    ...  ${ff_profile_dir}=None

    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  headless
    ${options}=  Call Method  ${options}  to_capabilities

    Create WebDriver
    ...  driver_name=Remote
    ...  alias=${alias}
    ...  command_executor=${remote_url}
    ...  desired_capabilities=${options}

    Go To  ${url}
