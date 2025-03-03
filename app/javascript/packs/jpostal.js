document.addEventListener("DOMContentLoaded", function() {
  const zipcodeInput = document.getElementById("zipcode");
  
  if (!zipcodeInput) {
    console.error("zipcode の input 要素が見つかりません");
    return;
  }

  zipcodeInput.addEventListener("blur", function() {
    let zipcode = zipcodeInput.value.replace("-", "").trim();
    if (zipcode.length === 7) {
      fetch(`/search_address?postal_code=${zipcode}`)
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP エラー: ${response.status}`);
          }
          return response.json();
        })
        .then(data => {
          if (data.error) {
            alert("住所が見つかりませんでした");
          } else {
            document.getElementById("prefecture").value = data.prefecture;
            document.getElementById("city").value = data.city;
            document.getElementById("street").value = data.street;
          }
        })
        .catch(error => console.error("エラー:", error));
    }
  });
});