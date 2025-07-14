function seconds(seconds) {
  const h = Math.floor(seconds / 3600);
  const m = Math.floor(seconds / 60);
  const s = Math.floor(seconds % 60);

  if (h > 0) {
    return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
  }

  return `${m}:${s.toString().padStart(2, '0')}`;
}
