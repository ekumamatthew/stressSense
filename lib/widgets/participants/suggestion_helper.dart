/// suggestion_helper.dart
class StressSuggestion {
  final String level; // "🔴 High Stress"
  final String message; // one‑sentence advice
  final List<String> tips; // bullet points

  StressSuggestion(this.level, this.message, this.tips);
}

StressSuggestion buildSuggestion(double avg) {
  if (avg >= 80) {
    return StressSuggestion(
      '🔴 High Stress',
      "You seem quite stressed. Take a 5–10 min break before continuing with your task.",
      [
        "🌬️ Deep breathing – Inhale 4 s, hold 4 s, exhale 4 s (×5).",
        "🎧 Play calming sounds – nature, rain, ocean waves.",
        "🧍 Light stretching or a short walk.",
      ],
    );
  } else if (avg >= 50) {
    return StressSuggestion(
      '🟠 Medium Stress',
      "You're doing okay, but a 2–5 min pause can help reset.",
      [
        "💦 Drink water.",
        "✍️ Jot down a thought for 1 min.",
        "🔄 Change position or environment briefly.",
      ],
    );
  } else {
    return StressSuggestion(
      '🟢 Low Stress',
      "You seem calm. Keep working, but take micro‑pauses (1–2 min).",
      [
        "💚 Stay hydrated.",
        "🎶 Soft background music.",
        "🌱 Quick gratitude check‑in.",
      ],
    );
  }
}
