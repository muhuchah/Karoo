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
> URL = http://127.0.0.1:8000/users/register/

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

```json
{
    "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxNDI0MDk3MSwiaWF0IjoxNzExNjQ4OTcxLCJqdGkiOiI3ODQ2ZDA2NTNhZDY0NDFiOGE0MGI3MDA0ZGIxYWIwMiIsInVzZXJfaWQiOjF9.z9bwBv_2Ehp7i1O2Ayi0ONHoaAKYsLyBdD-D3qXwXvg"
}
```
### Responses
#### If refresh token is not provided
```json
{ 
    "error": "Missing refresh token"
}
```
#### If logout was successful
```json
{
    "message": "You have been successfully logged out."
}
```

#### If it wasn't successful
```json
{
    "message": "An error occurred during logout."
}
```