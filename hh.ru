def hhru():
    from openpyxl import load_workbook
    import pandas as pd
    import xlrd

    options = webdriver.ChromeOptions()
    options.add_argument(
        'user-agend=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36')
    options.add_argument("--disable-blink-features=AutomationControlled")
    browser = webdriver.Chrome(
        executable_path="chromedriver.exe", options=options)

    list = 0
    head = []

    while list < 39:
        browser.get(f'https://kazan.hh.ru/vacancies/programmer?page={list}')

        time.sleep(5)
        element = browser.find_elements(By.CSS_SELECTOR,'.vacancy-serp-item')
        for i in element:
            head_text = i.find_element(By.CSS_SELECTOR,'.bloko-link').text
            head.append(f" {head_text}")

        list+=1

    browser.close()
    browser.quit()


    df = pd.DataFrame()
    df['Work'] = head

    writer = pd.ExcelWriter('./work.xlsx', engine='xlsxwriter')
    df.to_excel(writer, sheet_name='Лист1', index=False)
    writer.sheets['Лист1'].set_column('A:A', 60)
    writer.save()


    wb = load_workbook("./work.xlsx")

    sheet = wb.active
    rows = sheet.max_row

    python = 0
    js = 0
    sql = 0
    java = 0
    php = 0
    csh = 0
    cplus = 0
    go = 0
    ruby = 0
    back = 0
    front = 0

    lp = ["SQL", "JavaScript", "Python", "Java", "PHP", "C#", "C++", "Go", "Ruby", "Backend", "Frontend", "JS"]
    work = ""

    for i in range(rows):
        if i == 0:
            i = 1
        work = sheet[f'A{i}'].value

        for x in lp:
            if len(work.split(x)) == 2:
                if x == "SQL":
                    sql += 1
                elif x == "JavaScript" or x == "JS":
                    js += 1
                elif x == "Python":
                    python += 1
                elif x == "Java":
                    java += 1
                elif x == "PHP":
                    php += 1
                elif x == "C#":
                    csh += 1
                elif x == "C++":
                    cplus += 1
                elif x == "Go":
                    go += 1
                elif x == "Ruby":
                    ruby += 1
                elif x == "Backend":
                    back += 1
                elif x == "Frontend":
                    front += 1

    print("SQL: ", sql)
    print("JavaScript: ", js)
    print("Python: ", python)
    print("Java: ", java)
    print("PHP: ", php)
    print("C#: ", csh)
    print("C++: ", cplus)
    print("Go: ", go)
    print("Ruby: ", ruby)
    print("Backend: ", back)
    print("Frontend: ", front)
