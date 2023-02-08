// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("keydown", function(event) {
  if (event.key === "Enter") {
    var textarea = event.target;
    var start = textarea.selectionStart;
    var end = textarea.selectionEnd;
    var text = textarea.value;

    textarea.value = text.substring(0, start) + "\n• " + text.substring(end);
    textarea.selectionStart = textarea.selectionEnd = start + 3;

    event.preventDefault();
  }
});
