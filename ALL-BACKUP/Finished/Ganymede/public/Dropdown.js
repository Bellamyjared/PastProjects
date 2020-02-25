function myFunction() {
  document.getElementById("myDropdown").classList.toggle("show");
}
window.onclick = function(event) {
  if (!event.target.matches('.downlogo')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDrop = dropdowns[i];
      if (openDrop.classList.contains('show')) {
        openDrop.classList.remove('show');
      }
    }
  }
}
//Brandon W Cuthebrtson