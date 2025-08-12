import React from "react";

export default function ProductList({ products, onAdd }) {
  return (
    <div>
      <h2>Products</h2>
      <ul style={{ listStyle: "none", paddingLeft: 0 }}>
        {products.map((p) => (
          <li key={p.code} style={{ marginBottom: 8 }}>
            <strong>{p.name}</strong> - €{(p.price_cents / 100).toFixed(2)}
            <button onClick={() => onAdd(p.code)}>Add</button>
          </li>
        ))}
      </ul>
    </div>
  );
}
