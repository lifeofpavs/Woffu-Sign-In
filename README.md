# Woffu Sign In

Welcome to Woffu Sign in, a Ruby CLI that will help you signin into your Woffu account and clock in with a quick command.
There are some special environment variables that should be set before running it:

 -`WOFFU_URL`: Your company's woffu URL so that the script knows where to look navigate
 -`UI`(optional): This variable would allow you to see what is happening when the script is being executed

## Nuances

1. The script looks for a file called `user_data.txt` in order to look for the username and password associate with the account (Note that username/password should be enabled for it to work). The data would be read and stored in base64 to avoid plain text. Despite of that, base64 **IS NOT SECURE** so be aware of the problems it could cause.

2. If the file is not created, the CLI would display the option for the user to create the file. The user should just input its username and password and it will be stored in base64.

## Dependencies

 The script uses `capybara` and `selenium` to work. Also, it uses Google Chrome's webdriver so, install it if you don't have it.