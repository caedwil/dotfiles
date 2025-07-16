function seconds(value, options = { condensed: false, days: true, hours: true, minutes: true, seconds: true }) {
  options.condensed = options.condensed ?? false;
  options.days = options.days ?? true;
  options.hours = options.hours ?? true;
  options.minutes = options.minutes ?? true;
  options.seconds = options.seconds ?? true;

  const d = Math.floor(value / 86_400);

  const h = Math.floor(value / 3600);
  const hh = (h % 24).toString().padStart(options.condensed ? 2 : 0, '0');

  const m = Math.floor(value / 60);
  const mm = (m % 60).toString().padStart(options.condensed ? 2 : 0, '0');

  const s = Math.floor(value % 60);
  const ss = s.toString().padStart(options.condensed ? 2 : 0, '0');

  if (options.condensed) {
    if (d > 0 && options.days) {
      let result = `${d}`;

      if (options.hours) result += `:${hh}`;
      if (options.minutes) result += `:${mm}`;
      if (options.seconds) result += `:${ss}`;

      return result;
    }

    if (h > 0 && options.hours) {
      let result = `${h}`;

      if (options.minutes) result += `:${mm}`;
      if (options.seconds) result += `:${ss}`;

      return result;
    }

    if (options.minutes) {
      let result = `${m}`;

      if (options.seconds) result += `:${ss}`;

      return result;
    }

    if (options.seconds) {
      return `${s}`;
    }

    return '';
  }

  if (d > 0 && options.days) {
    let result = `${d}d`;

    if (options.hours) result += ` ${hh}h`;
    if (options.minutes) result += ` ${mm}m`;
    if (options.seconds) result += ` ${ss}s`;

    return result;
  }

  if (h > 0 && options.hours) {
    let result = `${h}h`;

    if (options.minutes) result += ` ${mm}m`;
    if (options.seconds) result += ` ${ss}s`;

    return result;
  }

  if (options.minutes) {
    let result = `${m}m`;

    if (options.seconds) result += ` ${ss}s`;

    return result;
  }

  if (options.seconds) {
    return `${s}s`;
  }

  return '';
}
