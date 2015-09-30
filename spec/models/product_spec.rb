require 'spec_helper'

describe Product do
  context "Payment Analytics" do
    let(:product) {Product.create(id: 1, name: "good product", short_description: "lalala", price: 100)}
    before do
      product
      Payment.create(created_at: Time.now, price: 100, product: product)
      Payment.create(created_at: Time.now, price: 150, product: product)
      Payment.create(created_at: 2.days.ago, price: 150, product: product)
      Payment.create(created_at: 10.days.ago, price: 200, product: product)
      Payment.create(created_at: 1.year.ago, price: 1000, product: product)
    end
    describe "sales_today" do
      it "calculates the total sales for the day" do
        expect(Product.first.sales_today).to eq(250)
      end
    end
    describe "sales_week" do
      it "calculates the total sales for the week" do
        expect(Product.first.sales_week).to eq(400)
      end
    end
    describe "sales_month" do
      it "calculates the total sales for the month" do
        expect(Product.first.sales_month).to eq(600)
      end
    end
    describe "sales_total" do
      it "calculates the total sales" do
        expect(Product.first.sales_total).to eq(1600)
      end
    end

    describe "sales(today)" do
      it "calculates the sales total for the day given" do
        expect(Product.first.sales(Time.now)).to eq(250)
      end
    end
  end
end