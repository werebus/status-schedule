Slack status scheduler. Uses [whenever][whenever] to schedule API calls to
Slack that set your status.

Setup
=====
Get an access token that has at least the "users.profile:read" and
"users.profile:write" OAuth scopes. You _can_ use a [legacy token][lt],
although there's a reason they're called that.

Copy `config/application.yml.example` to `config/application.yml` and fill
in your Slack access token.

Next, copy `config/status_schedule.rb.example` over to 
`config/status_schedule.rb`. This is where _your_ schedule will go.

Usage
=====
There are three ways to interact with your status in this project.

Whenever Schedule
-----------------
Your schedule is defined in `config/status_schedule.rb`. You should be familiar
with Whenever's syntax, but in addition there are some custom job types
defined:

```ruby
every :day, at: '9:00' do
  change :status, from: 'old', text: 'New Stuff', emoji: 'new'
end
```

This job changes your status to "New Stuff" with the `new` emoji, but **only**
if it is currently the `old` emoji. This allows you to conditionally set your
status. You may also specify an empty string (`''`) as your `from:` which will
only set your status if it is currently blank.

```ruby
every 2.hours do
  clear :status
end
```

Clears your status, easy enough.

```ruby
every :tuesday, at: '12:00' do
  set :status, text: 'Lunching', emoji: 'pizza'
end
```

Sets your status. For both `change` and `set`, you can leave either the `text`
or the `emoji` blank (or both, in which case it's the same as `clear`

Rake tasks
----------
You can also interact with the Rake tasks directly:

* `rake "status:change[from,text,emoji]"` - Change status conditionally. This
    works the same as the whenever job explained above.
* `rake status:clear` - Clears your status
* `rake "status:set[text,emoji]"` - Set your current status.

Ruby API
--------
Begin by initializing a new instance of a `StatusChanger`. You may pass a
single `String` as your access token, but if you don't it defaults to
`ENV['slack_token']`.

```ruby
sc = StatusChanger.new
```

---

`#current` returns a handy `Hash` with your current status:

```ruby
sc.current  #=> {:text=>"Working remotely", :emoji=>:house_with_garden}
```

---

`#clear` clears your status.

```ruby
sc.clear  #=> {:text=>"", :emoji=>:""}
```

---

`#set` sets your status. Both the `text` and `emoji` are optional keyword
arguments.

```ruby
#These are all the same:
sc.set(text: 'Vacation', emoji: :palm_tree)
sc.set(text: 'Vacation', emoji: 'palm_tree')
sc.set(text: 'Vacation', emoji: ':palm_tree:')

#The default emoji on Slack is :speach_balloon:
sc.set(text: 'Pondering')

#This is equivalent to sc.clear
sc.set
```

---

`#change` conditionally sets your status if your current status meets a
particular condition. It takes two keyword arguments:

1. `from:` this is the condition, it's optional, but if specified it controls
   whether or not to change your status:

    * If `from:` is a `String`, your status will only be changed if the **text**
      of your current status is that exact `String`
    * If `from:` is a `Regexp`, your status will only be changed if the **text**
      of your current status is matched by that `Regexp`
    * If `from:` is a `Symbol`, your status will only be changed if the
      **emoji** of your current status is that `Symbol`
    * If `from:` is omitted or `nil`, your status will be changed.

2. `to:` this is a required argument. It should be a `Hash` (like that
   returned by `#current`, but it's passed through to `#set`, so all the
   same possible combinations can be used here including an empty `Hash`.

```ruby
# Only if 'Away'
sc.change(from: 'Away', to: {text: 'Back', emoji: ':1234:'})

# Clear status if :palm_tree
sc.change(from: :palm_tree, to: {})

# Quick break if working remotely
sc.change(to: {text: 'Break', emoji: :clock1030}, from: /remote(ly?)$/i)
```

---

You can play with this API in irb by running `script/console`

[whenever]: https://github.com/javan/whenever
[lt]: https://api.slack.com/custom-integrations/legacy-tokens
