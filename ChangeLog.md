# Change Log

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
