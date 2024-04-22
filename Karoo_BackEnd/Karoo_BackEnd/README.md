In the name of ALLAH

# Back-End Document
Django REST Framework

## Register
> URL = http://127.0.0.1:8000/users/register/

You must **post** this values:
```json
{
	"password": "",
	"full_name": "",
	"email": ""
}
```

### If registeration was alright:
> status = 201_created
```json
{
	"message": "User registered successfully."
}
```

### If email is not valid
> status = 400_bad_request

```json
{
	"email": [
		"Enter a valid email address."
	]
}
```

### If user already exists:
> status = 400_bad_request

```json
{
	"email": [
		"Uesr with this user email already exists."
	]
}
```

### If the given values ​​are correct

An email will be sent to the user to activate the user account. The user cannot activate his account for login until he clicks on the link sent.
Sent emails have an expiration date of 2 minutes. If this time is over, the links sent in the email can no longer be used.

### How can the user get the activation link again?
It is enough for the user to request login. If his account is not active, the server will automatically send him an email.

## Login
> URL = http://127.0.0.1:8000/users/login/

You must **post** this values:
```json
{
	"password": "",
	"email": ""
}
```

### If password and email is correct and account is active:
> status = 200_OK

```json
{
    "refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNDM4MTUzNiwiaWF0IjoxNzA0Mjk1MTM2LCJqdGkiOiI2YWMwZWQ4NjE5MDQ0MTgyYTgwMTZmYjI4MDUyMjQ4ZiIsInVzZXJfaWQiOjYxfQ.5S7rJE9kSNg7tz0qOcFEtS2IYzO_UxFnIL-D8WRt5qs",
    "access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA0Mjk1NDM2LCJpYXQiOjE3MDQyOTUxMzYsImp0aSI6IjVmNzdkMGI3MDVmNjQzNTZhYmEyMjkwZTEwYjBiMzdiIiwidXNlcl9pZCI6NjF9.bUwZzBciJP85dCjaEV9ONZBimY-Aeg_Bx3LZz8j7w8s"
}
```

### If password and email is correct but account is not active:
> status = 401_Unauthorized

```json
{
	"non_field_errors": [
        "Your account is not active. Please check your email for the confirmation link.We sent new link for you."
	]
}
```

### If password or email is not correct:
> status = 401_Unauthorized

```json
{
	"non_field_errors": [
		"Invalid credentials"
	]
}
```

JWT security protocol is used for login in the above method. Therefore, the front-end can be given the value:
Token = "access" In the Header, for each authenticated request, fetch the necessary information from the backend.
How to place the new header in the rest of the requests is as follows:

| Key           | Value               |
|---------------|---------------------|
| Authorization | Bearer  accesstoken |

## Refresh Token
#### Endpoint
> URL http://127.0.0.1:8000/users/login/refresh/

#### Method
> POST

#### Parameters
```json
{
    "refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsIV4cCI6MTcxNDk5Mjg5NywiaWF0IjoxNzEyNDAwODk3LCJqdGkiOiI1ZmI0NmNhMDNiMDA0YjJiOGY0MDQzMDk4YzgxNmM2OSIsInVzZXJfaWQiOjF9.U8sSTMyj1zR9Bm-GQ4f_BgR3dBMkYuH0hH1Rrunuxpk"
}
```

#### Response
```json
{
    "access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoYWNjZXNzIiwiZXhwIjoxNzEzNTkzMjg3LCJpYXQiOjE3MTI0MDA4OTcsImp0aSI6ImZhOTYxNThhYWE5NTQ3M2VhMDc1OTE4ZmU0ZjUwMDI4IiwidXNlcl9pZCI6MX0.qQEUvNbv8bpoLjKiySQ5_XzCv_OaeUJiTnYcG74P-cQ"
}
```

## Setting
### Personal information
> URL http://127.0.0.1:8000/users/settings/personal-info/

#### GET method
returns personal information
```json
{
    "avatar": null,
    "full_name": "lashv",
    "phone_number": "0910000000",
    "email": "me@gmail.com"
}
```

#### PUT method
you can send some or all of the fields as follow:

```json
{
	"full_name": "ali"
}
```

and it returns 
```json
{
    "avatar": null,
    "full_name": "ali",
    "phone_number": "0910000000",
    "email": "me@gmail.com"
}
```

If user changes his email, an activation link will be sent to activate his email. and response would look like this:

```json
{
    "message": "Your new email address has been set, but it needs to be activated. Please check your inbox for an activation email.",
    "avatar": null,
    "full_name": "ali",
    "phone_number": "0910000000",
    "email": "new@gmail.com"
}
```

## Logout
> URL http://127.0.0.1:8000/users/logout/
> 
**Post** the refresh token to the URL as bellow:
```json
{
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDQxMzAyOSwiaWF0IjoxNzExODIxMDI5LCJqdGkiOiJmMzRiOGE4ZWZkN2I0ODU2YTZiOTg0OWQwYWIyZDNhMSIsInVzZXJfaWQiOjF9.8ONAz358PiAE52qF0snVT-JJWSSWXMoorgsuuZann9s"
}
```

### Responses
If Refresh Token Not Provided.
```json
{
    "error": "Missing refresh token"
}
```

If Logout Was Successful.
```json
{
    "message": "You have been successfully logged out."
}
```

If Logout Was Not Successful.
```json
{
    "message": "An error occurred during logout."
}
```

#### If it wasn't successful
```json
{
    "message": "An error occurred during logout."
}
```


## Address
### Generate data of provinces and cities
In back-end run this command:
> python manage.py generate_city
Then Iran provinces and cities is added to database.

### Retrieving All Provinces
To get all the provinces, send a **GET** request to the following url.

#### Endpoint
> URL http://127.0.0.1:8000/users/provinces/      

#### Method
> GET

#### Example Response
You then get a response like this:
```json
[
    {
        "id": 1,
        "name": "آذربایجان شرقی"
    },
    {
        "id": 2,
        "name": "آذربایجان غربی"
    },
    {
        "id": 3,
        "name": "اردبیل"
    }
]
```

### Retrieving All Cities

You can retrieve a list of all available cities in the system using a GET or POST request.

#### Endpoint
> URL http://127.0.0.1:8000/users/cities/

#### Method POST
If you want the cities of a specific province.

###### Request Parameters
```json
{
    "province": "اصفهان"
}
```

###### Example Response
```json
[
    {
        "id": 571,
        "name": "ادیمی",
        "province": 16
    },
    {
        "id": 572,
        "name": "اسپكه",
        "province": 16
    },
    {
        "id": 573,
        "name": "ایرانشهر",
        "province": 16
    }
]
```

If province not found you get this error:
````json
{
    "error": "Province not found"
}
````

#### Method GET
If you want the list of all cities.

### Address CRUD
#### Endpoint
> URL http://127.0.0.1:8000/users/settings/address-list/

#### Method: GET
###### Response
Returns a list of user addresses.

```json
[
    {
        "id": 2,
        "user": 1,
        "province_name": "اصفهان",
        "city_name": "اصفهان"
    }
]
```

#### Method: POST
You can create a new address for user.
You just need to post following fields.

```json
{
    "province": "اصفهان",
    "city": "اصفهان"
}
```
##### Responses
If 'province' not found or doesn't exist, you get HTTP_404_NOT_FOUND error:
```json
{
  "message": "Province does not exist."
}
```

If 'city' not found or doesn't exist, you get HTTP_404_NOT_FOUND error:
```json
{
  "message": "City does not exist."
}
```

If creating new address was successful, you get HTTP_201_CREATED:
```json
{
    "id": 4,
    "user": 1,
    "province_name": "اصفهان",
    "city_name": "اصفهان"
}
```

If any other exception occurs, you get HTTP_400_BAD_REQUEST:
```json
{
    "message": "Error creating address: {e}"
}
```

#### Endpoint
> URL http://127.0.0.1:8000/users/settings/address-edit/id

You need to add the id of that specific address in the url.

##### Method: GET
To get a specific address.

###### Response
If an address with that id doesn't exist:
```json
[
    "Not found!"
]
```

Otherwise:
```json
{
    "id": 2,
    "user": 1,
    "province_name": "اصفهان",
    "city_name": "اصفهان"
}
```

##### Method: PUT
If you want to edit a specific address.
You need to add all or some of the following fields to your body.

```json
{
    "province": "تهران",
    "city": "تهران"
}
```

###### Response
If it was successful, you get the updated data:
```json
{
    "id": 2,
    "user": 1,
    "province_name": "تهران",
    "city_name": "تهران"
}
```

If the province or city that was sent didn't exist,
that specific field won't be updated. you'll get same data.

for example if PUT something like this:
```json
{
    "province": "fake city name",
    "city": "تهران"
}
```
you'll get:
```json
{
    "id": 2,
    "user": 1,
    "province_name": "تهران",
    "city_name": "تهران"
}
```
because "province": "fake city name" is not a province name.

#### Method: DELETE
If you want to delete a specific address.

###### Response
If an address with that id doesn't exist, you get a HTTP_404_NOT_FOUND error:
```json
{
    "message": "Address does not exist"
}
```

If delete was successful:
It would return null (means data is deleted) and
it's status is HTTP_204_NO_CONTENT.

## Restore database
> python manage.py dbrestore

## Job

### Job List

##### Endpoint
> URL  http://127.0.0.1:8000/jobs/list/

##### Method
> GET

##### Response
```json
[
    {
        "id": 1,
        "title": "Cry",
        "description": "",
        "average_rating": 0.0,
        "main_picture": null,
        "province": 1,
        "city": 1
    }
]
```