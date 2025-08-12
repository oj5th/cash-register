import React from "react";

export default function Cart({ items, onCheckout }) {
  const counts = items.reduce((acc, c) => {
    acc[c] = (acc[c] || 0) + 1;
    return acc;
  }, {});

  return (
    <div style={{ marginTop: 20 }}>
      <h2>Cart</h2>
      {items.length === 0 ? (
        <p>Empty</p>
      ) : (
        <>
          <ul>
            {Object.entries(counts).map(([code, count]) => (
              <li key={code}>
                {code} x {count}
              </li>
            ))}
          </ul>
          <button onClick={onCheckout}>Checkout</button>
        </>
      )}
    </div>
  );
}
