*** Settings ***
Library    RequestsLibrary
Library    Collections
#The collection library is used for the response header data or any type of dictionary or list data

*** Variables ***
${Base_URL}    https://thetestingworldapi.com
${ENDPOINT}   /api/studentsDetails
${AUTH_HEADER}      {"Content-Type": "application/json"}

*** Test Cases ***

TC1_Return the details of all students (GET)

    create session   my_session    ${Base_URL}
    ${response}=    get on session    my_session    ${ENDPOINT}

    log to console    ${response.status_code} #Log to console is used for show the response on the console
    log to console    ${response.content}
    log to console    ${response.headers}

    #Validation the response status code
    ${status_code}=    convert to string    ${response.status_code}  # The Convert string is used for convert interger data to string data
    should be equal    ${status_code}   200

    #Validation the response body
    ${body}=    convert to string   ${response.content}
    should contain    ${body}   "SdddddPradddsad"

    #Validation the response header (Content-Type)
    ${contenttypevalue}=    get from dictionary    ${response.headers}    Content-Type
    should be equal    ${contenttypevalue}      application/json; charset=utf-8


TC2_Add a new student details (POST)

    Create Session    mysession    ${BASE_URL}    headers=${AUTH_HEADER}    verify=False
    ${payload}=    Create Dictionary    first_name=Rubel   middle_name=Hosain    last_name=Riyon    date_of_birth=06-03-1999
    ${response}=   post on session    mysession    ${ENDPOINT}    json=${payload}

    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

    #Validation the response status code
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   201

    #Validation the response body
    ${body}=    convert to string   ${response.content}
    should contain    ${body}   "first_name":"Rubel"

    #Validation the response header (Content-Type)
    ${contenttypevalue}=    get from dictionary    ${response.headers}    Content-Type    varify=false
    should be equal    ${contenttypevalue}      application/json; charset=utf-8

    #Validation the response header (Content-Length)
    ${contenttypevalue}=    get from dictionary    ${response.headers}    Content-Length
    should be equal    ${contenttypevalue}      108


TC3_Update an existing student details based on student ID-10492725 (PUT)


    Create Session    mysession    ${BASE_URL}    headers=${AUTH_HEADER}    verify=False
    ${payload}=    Create Dictionary    id=10492725    first_name=Alisha   middle_name=Anjum    last_name=Dola    date_of_birth=01-01-2000
    ${response}=   put on session    mysession    /api/studentsDetails/10492725    json=${payload}

    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

    #Validation the response status code
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    #Validation the response body
    ${body}=    convert to string   ${response.content}
    should contain    ${body}   "update  data success"

TC4_After update student details check the return details of a specific student based on student ID-10492725 (GET)

    create session   my_session    ${Base_URL}
    ${response}=    get on session    my_session    /api/studentsDetails/10492725

    log to console    ${response.status_code}
    log to console    ${response.content}
    log to console    ${response.headers}

    #Validation the response status code
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${status_code}   200

    #Validation the response body
    ${payload}=    convert to string   ${response.content}
    should contain    ${payload}   "first_name":"Alisha"

    #Validation the response header (Content-Type)
    ${contenttypevalue}=    get from dictionary    ${response.headers}    Content-Type
    should be equal    ${contenttypevalue}      application/json; charset=utf-8



