# Change Log

## 0.8. - Not specific to Devise

* Can specify the sign in & authenticate methods to use
* Defaults for missing config now working 

## 0.7.0 - Redirect configuration

* Options for specifying where redirects go to and their defaults:

    config.redirect_on_impersonate = "/"
    config.redirect_on_revert = "/impersonate"

* Fixed override code, so you can actually override now.

## 0.6.0 - Configuration

* Options and their defaults:

    config.user_class           = "User"
    config.user_finder          = "find"   # User.find
    config.user_id_column       = "id"     # Such that User.find(aUser.id) works
    config.user_is_staff_method = "staff?" # current_user.staff?

* Generator

    rails g user_impersonate

## 0.5.0 - Initial experimental release

* Impersonation mechanism works
* No generators
* No configurability
