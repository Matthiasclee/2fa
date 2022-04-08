# 2fa

### 2fa is a gem that uses the twilio-ruby library to do two factor authentication in rails apps.

## Setup
* Add `gem '2fa'` to your `Gemfile`
* `bundle install`
* Add `mount TFA::Engine => '/tfa', as: :tfa` to your `config/routes.rb`
* `rails db:migrate`
* Set the env vars, `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`, and `TWILIO_SENDING_PHONE` to your twilio account sid, twilio auth token, and the phone number to send from in `+155566667777` format respectively. (You do need a twilio account for this)

## Usage

### require\_tfa()
To require 2FA anywhere in your app, simply call the `helpers.require_tfa` method. 
This method takes in a phone number, the http params to be used after, the url to redirect to after, and the http method to use after, the length of the code, and the message to send.
Only the phone number, the http params, and the url are required. The rest default to post, 6, and "Your two factor authentication code is:\n\n{code}"

You can use the method like this:
```rb
  helpers.require_tfa(phone_number: '+15556667777', http_params: helpers.tfa_friendly_params(params), url: request.path)
```

You can see that we givve a phone number, a url, and http params. We are though passing the params through `helpers.tfa_friendly_params`. That method just converts the params into a hash and some other stuff.

### if\_tfa and no\_tfa
You can check in your controller if you are authenticated with tfa by putting the code to only run with tfa in a `if_tfa` block and the other stuff in a `no_tfa` block.
An example of a full controller method with tfa auth:
```rb
def create
  helpers.no_tfa do
    helpers.require_tfa(phone_number: '+15556667777', http_params: helpers.tfa_friendly_params(params), url: request.path)
  end

  helpers.if_tfa do
    @example = Example.new(example_params)

    respond_to do |format|
      if @example.save
        format.html { redirect_to example_url(@example), notice: "example was successfully created." }
        format.json { render :show, status: :created, location: @example }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @example.errors, status: :unprocessable_entity }
      end
    end
  end
end
```
This is just a default scaffolded controller but with tfa auth.

This isn't perfect as in theory someone could pass a different unused tfa by inspecting the form, so to prevent this, you can pass a `expected_phone: ` argument to `no_tfa` or `if_tfa` to add that requirement.
```rb
helpers.if_tfa(expected_phone: @user.phone) do
  #...
end
```

### Custom tfa check page
To make a custom tfa check page, make the file `app/views/tfa/tfas/_show.html.erb`.
In this file you have the instance variable, `@tfa` and a formatted phone number (`@tfa_phone`), and some more.
You need to have the default form stuff in there:
```rb
<%= form_with(url: @url, method: @method) do |f|  %>
  <%= f.hidden_field :tfa_id, value: @tfa.id %>
  <% @http_params.each do |p| %>
    <%= f.hidden_field p[0].to_sym, value: p[1].to_s.gsub("\0001", ':').gsub("\0002", ',').gsub("\0003", '#') %>
  <% end %>

  <div class='field'>
    <%= f.number_field :code %>
  </div>

  <div class='actions'>
    <%= f.submit 'Go' %>
  </div>
<% end %>
```
