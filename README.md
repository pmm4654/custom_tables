# CustomTables

This gem provides an easily configurable way to create index tables.  It's aim is to make it easier for you to modify the data and the order of the data the exists on your tables.  It is a work in progress, but the end goal is to have this configurable by user (if they are a part of your site) via a drag-and-drop interface where the settings would be savable by each individual user. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'custom_tables', git: 'https://github.com/pmm4654/custom_tables.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install custom_tables

## Usage

In your controller, add `has_custom_index` and add the key `:default_headers` with a value of the column headers/field names as an array.  Also add your translation base (using I18n).  

For the example below, your `en.yml` would include the following:

```ruby
invoice:
  amount: 'Amount'
  customer_name: 'Customer Name'
  title: 'Title'
  description: 'Description'
```


The implementation in your controller would be as follows:
```ruby
has_custom_index :default_headers => [:amount, :customer_name, :title, :description], 
                 :translation_base => 'invoice'
```

Create a tempalte for your tables in `custom_tables/_custom_table.html.erb`
```ruby
<p id="notice"><%= notice %></p>
<h1><%= I18n.t("#{@translation_base}.table_header") %></h1>
<table>
  <thead>
    <tr>    
    <% @default_headers.each do |field_name| %>
      <td><%= I18n.t("#{@translation_base}.#{field_name}") %></td>
    <% end %>
    </tr>
  </thead>
  <tbody>
    <% resources.each do |resource| %>
      <tr>
      <% @default_headers.each do |field_name| %>
        <% if @index.respond_to?(field_name) %>
          <td><%= resource.send(field_name) %></td>
        <% else %>
          <td><%= resource.index_display_value_for(field_name) %></td>
        <% end %>
      <% end %>
        <td><%= link_to 'Show', resource %></td>
        <td><%= link_to 'Edit', send("edit_#{resource.class.name.underscore}_path", resource) %></td>
        <td><%= link_to 'Destroy', resource, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>

</table>

```

On your index page use the `render_custom_table` helper method.  THis renders your custom table template for use in the `:custom_table` block.  You then yield to that block and your table will be rendered.  Now when you want to modify your headers or their position, just modify the array in the controller.
```
<%= render_custom_table(@customers) %>

<%= yield(:custom_table) if content_for?(:custom_table) %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/custom_tables. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CustomTables project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/custom_tables/blob/master/CODE_OF_CONDUCT.md).
