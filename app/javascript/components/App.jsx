import React, { useState } from "react";
import ProductList from "./ProductList";
import Cart from "./Cart";

export default function App(props) {
  // props.products is an array passed from Rails view (codes, names, price_cents)
  const initialProducts = props.products || [
    { code: "GT", name: "Green Tea", price_cents: 310 },
    { code: "ST", name: "Strawberries", price_cents: 500 },
    { code: "CF", name: "Coffee", price_cents: 1150 },
  ];

  const [products] = useState(initialProducts);
  const [cart, setCart] = useState([]);

  function addToCart(code) {
    setCart((prev) => [...prev, code]);
  }

  async function checkout() {
    const resp = await fetch("/api/v1/checkout", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ items: cart }),
    });

    if (!resp.ok) {
      const err = await resp.json();
      alert("Error: ", +(err.error || JSON.stringify(err)));
      return;
    }

    const data = await resp.json();
    alert(`Total: €${data.total}`);
  }

  return (
    <div style={{ padding: 20 }}>
      <h1>Checkout Demo</h1>
      <ProductList products={products} onAdd={addToCart} />
      <Cart items={cart} onCheckout={checkout} />
    </div>
  );
}
