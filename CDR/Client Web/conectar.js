function connection() {
  var username = document.getElementById("username").value;
  var password = document.getElementById("password").value;
  var request = new XMLHttpRequest();
  request.open("GET", "http://localhost:8080/users?uid=" + password, true);
  request.onload = function (response, err) {
    // Success!
    data = JSON.parse(this.response);
    if (username === data[0].Nombre) {
      localStorage.setItem("nombre", data[0].Nombre);
      var encrypted = CryptoJS.AES.encrypt(password, "AE1234KSWRCA");
      localStorage.setItem("pass", encrypted);
      window.location = "inici.html";
    } else {
      alert("Incorrect username or password");
    }
  };

  request.onerror = function () {
    alert("Server is offline :(, guess you shouldn't study now");
  };

  request.send();
}
