# User Impersonate

Allow staff users to impersonate your normal users: see what they see, only do what they can do.

## Example usage

When logged in as a Staff user, navigate to the `/impersonate` section that is mounted with this Rails engine:

<img src="https://img.skitch.com/20120916-exjmwkufj16kijjdsaf2dpn6tk.png" alt="navigate to impersonation section somehow" />

Search for a user and impersonate them:

<img src="https://img.skitch.com/20120916-b1exb1penw4cdt41c45gxrphbr.png" alt="Impersonate a user" />

When you are impersonating a user you see what they see, with a header section above:

<img src="https://img.skitch.com/20120916-xq5q5gfyfm14ibkqf9e36hb3yp.png" alt="Impersonating a user" />

## Installation

Add to your layout the following HAML

``` haml
- if staff_user
  = render 'user_impersonate/header'
```

or ERb:

``` erb
<% if staff_user %>
  <%= render 'user_impersonate/header' %>
<% end %>
```

Engine Yard Cloud uses a header that looks like:

![](https://img.skitch.com/20120915-mk8mnpdsu5nuym3bxs678qf1a8.png)

The HAML partial for this header is:

``` haml
%div#impersonating
  .impersonate-controls.page
    .impersonate-info.grid_12
      You (
      %span.admin_name= current_staff_user.name
      ) are impersonating
      %span.user_name= link_to current_user.name, url_for([:admin, current_user])
      ( User id:
      %span.user_id= current_user.id
      )
      - if current_user.no_accounts?
        ( No accounts )
      - else
        ( Account name:
        %span.account_id= link_to current_user.accounts.first.name, url_for([:admin, current_user.accounts.first])
        , id:
        %strong= current_user.accounts.first.id
        )
    .impersonate-buttons.grid_12
      = form_tag url_for([:ssh_key, :admin, current_user]), :method => "put" do
        %span Support SSH Key
        = select_tag 'public_key', options_for_select(current_staff_user.keys.map {|k| k.name})
        %button{:type => "submit"} Install SSH Key
      or
      = form_tag [:admin, :revert], :method => :delete, :class => 'revert-form' do
        %button{:type => "submit"} Revert to admin
```