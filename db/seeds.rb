# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Events

events =
[{
  'external_user_id' => '11',
  'payload' =>
   { 'id' => 'A1',
     'status' => 'open',
     'products' => [{ 'sku' => 'X1', 'quantity' => '2' }, { 'sku' => 'X2', 'quantity' => '3' }] },
  'topic' => 'order_created'
},
 {
   'external_user_id' => '11',
   'payload' =>
   { 'id' => 'A3',
     'status' => 'open',
     'products' => [{ 'sku' => 'X2', 'quantity' => '4' }, { 'sku' => 'X2', 'quantity' => '3' }] },
   'topic' => 'order_created'
 }]

events.each { |event| Event.create(event) }

# Webhooks

webhooks = [{
  'url_path' => 'https://reqbin.com/echo?t=11122',
  'external_user_id' => '11',
  'topic' => 'order_created'
},
            {
              'url_path' => 'https://reqbin.com/echo?t=11222',
              'external_user_id' => '12',
              'topic' => 'order_created'
            }]

webhooks.each { |webhook| Webhook.create(webhook) }

# Messages

messages = [{
  'event_id' => Event.first.id,
  'webhook_id' => Webhook.first.id,
  'attempts' => 1,
  'delivery_status' => 1,
},
            {
              'event_id' => Event.last.id,
              'webhook_id' => Webhook.first.id,
              'attempts' => 3,
              'delivery_status' => 2,
            }]

messages.each { |message| Message.create(message) }
