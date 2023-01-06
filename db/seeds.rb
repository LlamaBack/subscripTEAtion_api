# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer = FactoryBot.create(:customer)
teas = FactoryBot.create_list(:tea, 5)

sub1 = FactoryBot.create(:subscription, customer: customer)
sub2 = FactoryBot.create(:subscription, customer: customer, status: :cancelled)

FactoryBot.create(:tea_subscription, subscription: sub1, tea: teas[1])
FactoryBot.create(:tea_subscription, subscription: sub1, tea: teas[2])
FactoryBot.create(:tea_subscription, subscription: sub2, tea: teas[3])
FactoryBot.create(:tea_subscription, subscription: sub2, tea: teas[4])
FactoryBot.create(:tea_subscription, subscription: sub2, tea: teas[0])
