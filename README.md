# User Impersonate

Allow staff users to impersonate your normal users: see what they see, only do what they can do.

This concept and code was extracted from [Engine Yard Cloud](http://www.engineyard.com/products/cloud), which we use when we want to help support a customer remotely.

This Rails engine currently supports the following Rails authentication systems:

* [Devise](https://github.com/plataformatec/devise)

## Example usage

When you are impersonating a user you see what they see, with a header section above:

<img src="https://img.skitch.com/20120919-c8382rgdcub7gsh2p82k8reng3.png" alt="Impersonating a user" />

## Installation

Add the gem to your Rails application's Gemfile and run `bundle`:

``` ruby
gem "user_impersonate"
```

Run the (sort of optional) generator:

```
bundle
rails g user_impersonate
```

This adds the following line within your `config/routes.rb`:

``` ruby
mount UserImpersonate::Engine => "/impersonate", as: "impersonate_engine"
```

Include in your layout files support for `flash[:error]` and `flash[:notice]`, such as:

``` erb
<p class="notice"><%= flash[:notice] %></p>
<p class="alert"><%= flash[:error] %></p>
```

Next, add the impersonation header to your layouts:

``` erb
<% if current_staff_user %>
  <%= render 'user_impersonate/header' %>
<% end %>
```

Next, add staff concept to your User model.

To test the engine out, make all users staff!

``` ruby
# app/models/user.rb

def staff?
  true
end

# String to represent a user (email, name, etc)
def to_s
  email
end
```

You can now go to [http://localhost:3000/impersonate](http://localhost:3000/impersonate) to see the list of users, except your own user account. If you impersonate one you will see the magic!

## Integration

To support this Rails engine, you need to add some things.

* `current_user` helper within controllers & helpers
* `current_user.staff?` - your `User` model needs a `staff?` to identify if the current user is allowed to impersonate other users; if missing, no user can access impersonation system

### User#staff?

One way to add this helper is to add a column to your User model:

```
rails g migration add_staff_flag_to_users staff:boolean
rake db:migrate db:test:prepare
```

## Customization

### Header


You can override the bright red header by creating a `app/views/user_impersonate/_header.html.erb` file (or whatever template system you like).

For example, the Engine Yard Cloud uses a header that looks like:

![](https://img.skitch.com/20120915-mk8mnpdsu5nuym3bxs678qf1a8.png)

The `app/views/user_impersonate/_header.html.haml` HAML partial for this header would be:

``` haml
%div#impersonating
  .impersonate-controls.page
    .impersonate-info.grid_12
      You (
      %span.admin_name= current_staff_user
      ) are impersonating
      %span.user_name= link_to current_user, url_for([:admin, current_user])
      ( User id:
      %span.user_id= current_user.id
      )
      - if current_user.no_accounts?
        ( No accounts )
      - else
        ( Account name:
        %span.account_id= link_to current_user.accounts.first, url_for([:admin, current_user.accounts.first])
        , id:
        %strong= current_user.accounts.first.id
        )
    .impersonate-buttons.grid_12
      = form_tag url_for([:ssh_key, :admin, current_user]), :method => "put" do
        %span Support SSH Key
        = select_tag 'public_key', options_for_select(current_staff_user.keys.map {|k| k})
        %button{:type => "submit"} Install SSH Key
      or
      = form_tag [:admin, :revert], :method => :delete, :class => 'revert-form' do
        %button{:type => "submit"} Revert to admin
```

### Redirects

By default, when you impersonate and when you stop impersonating a user you are redirected to the root url.

Configure alternate paths in `config/initializers/user_impersonate.rb`, which is created by the generator above.

``` ruby
# config/initializers/user_impersonate.rb
module UserImpersonate
  class Engine < Rails::Engine
    config.redirect_on_impersonate = "/"
    config.redirect_on_revert = "/impersonate"
  end
end
```

### User model & lookup

By default, it assumes the User model is `User`, that you use `User.find(id)` to find a user, and `aUser.id` to get the related id value.

You can fix this default behavior in `config/initializers/user_impersonate.rb`, which is created by the generator above.

``` ruby
# config/initializers/user_impersonate.rb
module UserImpersonate
  class Engine < Rails::Engine
    config.user_class           = "User"
    config.user_finder          = "find"         # User.find
    config.user_id_column       = "id"           # Such that User.find(aUser.id) works
    config.current_user_method  = "current_user" # Method to access current user
    config.user_is_staff_method = "staff?"       # current_user.staff?
  end
end
```
