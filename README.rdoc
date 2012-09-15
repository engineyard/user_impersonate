= UserImpersonate

This project rocks and uses MIT-LICENSE.

Add to your layout

``` haml
- if session.staff_user
  = render 'user_impersonate/header'
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