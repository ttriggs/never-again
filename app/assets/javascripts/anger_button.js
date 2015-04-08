var startingBackgroundColor = $("body").css("background-color");
var rgbArray = startingBackgroundColor.substring(
  4, startingBackgroundColor.length - 1).split(", "
);
var r = parseInt(rgbArray[0]);
var g = parseInt(rgbArray[1]);
var b = parseInt(rgbArray[2]);
var rage = 0;

function incrementRage() {
  if ( rage <= 50 ) {
    rage += 1;
  }
}

function rageLevel() {
  if ( rage <= 10 ) {
    return "a little ticked";
  }
  else if ( rage <= 20 ) {
    return "chafed";
  }
  else if ( rage <= 30 ) {
    return "hot under the collar";
  }
  else if ( rage <= 40 ) {
    return "rancorous";
  }
  else {
    return "explosive";
  }
}

$("#rage-button").click(function(){
    incrementRage();
    g = g - 5;
    b = b - 5;
    var rgb = "rgb(" + r + ", " + g + ", " + b + ")";
    $("body").css("background-color", rgb);
    $("#rage-button").text(rageLevel());
    $("#review_rage_level").val(rageLevel);
});
