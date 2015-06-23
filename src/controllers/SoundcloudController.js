controller = new BasicController({
  supports: {
    playpause: true,
    next: true,
    previous: true,
    favorite: true
  },
  playStateSelector: '.playControl',
  playStateClass: 'playing',
  playPauseSelector: '.playControl',
  nextSelector: '.skipControl__next',
  previousSelector: '.skipControl__previous',
  titleSelector: '.playbackSoundBadge__title > span:nth-child(2)',
  favoriteSelector: '.playbackSoundBadge__like',
  isFavoriteSelector: '.playbackSoundBadge__like.sc-button-selected'
});

controller.override('getArtist', function() {
  var el = document.querySelector(controller.titleSelector);
  if (!el) return "";
  var s = el.textContent;
  var parts = s.split(" - ");
  return parts.length > 1 ? parts[0] : "";
});

controller.override('getTitle', function() {
  var el = document.querySelector(controller.titleSelector);
  if (!el) return "";
  var s = el.textContent;
  var parts = s.split(" - ");
  return parts.length > 1 ? parts[1] : parts[0];
});

controller.override('getAlbumArt', function() {
	var art = document.querySelector('.playbackSoundBadge__avatar > div > span.image__full').style.backgroundImage.slice(4, -1);
    return art && art.replace(/\d{1,3}x\d{1,3}\.jpg/i, "500x500.jpg");
});
