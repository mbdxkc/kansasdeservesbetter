/*
  ============================================================================
  kansasdeservesbetter.com
  ============================================================================
  @file       js/site.js
  @desc       The two carousels and the Vote-section click event. The page
              loads js/site.min.js; run tools/build.sh after editing this.
  @author     mediaBrilliance digitalxtudio
  @version    0.1.0
  @updated    2026-10-21
  ============================================================================
*/

/* Carousel: arrows, a counter and auto-advance every 6 seconds. It pauses on hover,
   focus or touch, when the tab is hidden, and when the visitor presses Pause, and it
   never starts for visitors who ask for reduced motion. Without this script the track
   still scrolls by touch, trackpad and keyboard. */
document.querySelectorAll('.reel').forEach(function (reel) {

  var track = reel.querySelector('.reel-track'), nav = reel.querySelector('.reel-nav'),
      count = reel.querySelector('.reel-count'), play = reel.querySelector('.reel-play'),
      slides = track.children, still = matchMedia('(prefers-reduced-motion: reduce)').matches,
      stopped = still || !play, held = false, timer;
  nav.hidden = false;
  function step() { return slides[0].getBoundingClientRect().width + parseFloat(getComputedStyle(track).columnGap || 0); }
  function index() { return Math.round(track.scrollLeft / step()); }
  function atEnd() { return track.scrollLeft + track.clientWidth >= track.scrollWidth - 4; }
  function go(dir) {
    var left = (dir > 0 && atEnd()) ? -track.scrollLeft : step() * dir;
    track.scrollBy({ left: left, behavior: still ? 'auto' : 'smooth' });
  }
  function tick() { if (!stopped && !held && !document.hidden) go(1); }
  /* Button words come from data-* attributes on the Pause button, so /es/ can
     carry its own; English is the fallback. */
  function setStopped(v) {
    stopped = v; if (!play) return; play.setAttribute('aria-pressed', String(v));
    var d = play.dataset;
    play.textContent = v ? (d.play || 'Play') : (d.pause || 'Pause');
    play.setAttribute('aria-label', v ? (d.playLabel || 'Play slides') : (d.pauseLabel || 'Pause slides'));
  }
  setStopped(stopped);
  timer = setInterval(tick, 6000);
  nav.addEventListener('click', function (e) {
    var b = e.target.closest('.reel-btn'); if (!b) return;
    if (play && b === play) { setStopped(!stopped); return; }
    setStopped(true); go(+b.dataset.dir);
  });
  reel.addEventListener('mouseenter', function () { held = true; });
  reel.addEventListener('mouseleave', function () { held = false; });
  reel.addEventListener('focusin', function () { held = true; });
  reel.addEventListener('focusout', function () { held = false; });
  track.addEventListener('touchstart', function () { setStopped(true); }, { passive: true });
  track.addEventListener('keydown', function (e) {
    if (e.key === 'ArrowRight' || e.key === 'ArrowLeft') {
      e.preventDefault(); setStopped(true); go(e.key === 'ArrowRight' ? 1 : -1);
    }
  });
  /* a mouse can drag the track; touch already swipes natively */
  var drag = null;
  track.addEventListener('pointerdown', function (e) {
    if (e.pointerType !== 'mouse' || e.button !== 0) return;
    drag = { x: e.clientX, left: track.scrollLeft, moved: false };
    track.style.scrollSnapType = 'none';
  });
  addEventListener('pointermove', function (e) {
    if (!drag) return;
    var dx = e.clientX - drag.x;
    if (Math.abs(dx) > 4) { drag.moved = true; track.classList.add('dragging'); setStopped(true); }
    track.scrollLeft = drag.left - dx;
  });
  addEventListener('pointerup', function () {
    if (!drag) return;
    var moved = drag.moved; drag = null;
    track.classList.remove('dragging'); track.style.scrollSnapType = '';
    if (moved) {
      var i = Math.round(track.scrollLeft / step());
      track.scrollTo({ left: i * step(), behavior: still ? 'auto' : 'smooth' });
      track.addEventListener('click', function (ev) { ev.preventDefault(); ev.stopPropagation(); }, { capture: true, once: true });
    }
  });
  track.addEventListener('scroll', function () {
    count.textContent = Math.min(slides.length, index() + 1) + ' / ' + slides.length;
  }, { passive: true });
});

/* Counts clicks from the Vote section to the state's voter tools (VoterView,
   ballot application, photo ID list) as one Analytics event. Source citations
   under the section are not counted. */
document.querySelectorAll('#vote a[href*="voteks.org"], #vote a[href*="sos.ks.gov"]').forEach(function (a) {
  if (a.closest('.src')) return;
  a.addEventListener('click', function () {
    if (window.gtag) gtag('event', 'vote_link_click', { link_url: a.href });
  });
});
