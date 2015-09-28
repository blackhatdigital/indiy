require 'spec_helper'

describe Product do
  context "Payment Analytics" do
    let(:product) {Product.create(id: 1, name: "good product")}
    before do
      Payment.create(created_at: Time.now, price: 100, product_id: 1)
      Payment.create(created_at: Time.now, price: 150, product_id: 1)
      Payment.create(created_at: 2.days.ago, price: 150, product_id: 1)
      Payment.create(created_at: 10.days.ago, price: 200, product_id: 1)
      Payment.create(created_at: 1.year.ago, price: 1000, product_id: 1)
    end
    describe "sales_today" do
      it "calculates the total sales for the day" do
        expect(product.sales_today).to eq(250)
      end
    end
    describe "sales_week" do
      it "calculates the total sales for the week" do
        expect(product.sales_week).to eq(400)
      end
    end
    describe "sales_month" do
      it "calculates the total sales for the month" do
        expect(product.sales_month).to eq(600)
      end
    end
    describe "sales_total" do
      it "calculates the total sales" do
        expect(product.sales_total).to eq(1600)
      end
    end

    describe "sales(today)" do
      it "calculates the sales total for the day given" do
        expect(product.sales(Date.today)).to eq(250)
      end
    end
  end
end