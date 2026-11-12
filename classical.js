// Product detail mappings for Classical Necklaces
const classicalProducts = [
  "product.html",  // Card 1: Golden Temple Necklace
  "product2.html", // Card 2: Princess Chic Jewellery Sets
  "product3.html", // Card 3: Ratnavali Jewels Brass Gold-plated Red Jewellery Set
  "product4.html", // Card 4: Brado Jewellery Rose Gold-Plated Artificial Stone
  "product1.html", // Card 5: Zeneme Rose Gold-Plated CZ & AD Stone
  "product5.html", // Card 6: Shining Diva Fancy Pearl Choker
  "product6.html"  // Card 7: Sasitrends Gold Plated Traditional Neck Choker
];

// Like button toggle
const likeButtons = document.querySelectorAll('.like-btn');
likeButtons.forEach(btn => {
  btn.addEventListener('click', (e) => {
    e.stopPropagation();
    btn.classList.toggle('liked');
  });
});

// Buy Now (View Details)
const buyButtons = document.querySelectorAll('.buy-btn');
buyButtons.forEach((btn, index) => {
  btn.addEventListener('click', (e) => {
    e.stopPropagation();
    const target = btn.getAttribute('data-url') || classicalProducts[index] || "product.html";
    window.location.href = target;
  });
});