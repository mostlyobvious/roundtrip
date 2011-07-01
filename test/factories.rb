require "factory_girl"

Factory.define :user do |u|
  u.sequence(:email) { |n| "user#{n}@example.com" }
  u.password "s3cr3t"
  u.password_confirmation { |p| p.password }
end

Factory.define :admin, :parent => :user do |u|
  u.sequence(:email) { |n| "root#{n}@example.com" }
  u.admin true
end

Factory.define :ticket, :class => "Roundtrip::Ticket" do |t|
  t.summary "Someone is wrong on the internet!"
  t.association :reporter, :factory => :user
end
