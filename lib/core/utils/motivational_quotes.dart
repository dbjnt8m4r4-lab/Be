import 'dart:math';

class MotivationalQuote {
  final String quote;
  final String emoji;
  final String? author;

  const MotivationalQuote({
    required this.quote,
    required this.emoji,
    this.author,
  });
}

class MotivationalQuotes {
  static final List<MotivationalQuote> quotes = [
    const MotivationalQuote(
      quote: "Life is for the daring ones",
      emoji: "🔥",
    ),
    const MotivationalQuote(
      quote: "Readers are leaders",
      emoji: "📚",
    ),
    const MotivationalQuote(
      quote: "No risk, no story",
      emoji: "⚡️",
    ),
    const MotivationalQuote(
      quote: "Kill the boy and let the man be born",
      emoji: "🦁",
      author: "George R.R. Martin",
    ),
    const MotivationalQuote(
      quote: "Until death, all defeat is psychological",
      emoji: "💪",
      author: "Miyamoto Musashi",
    ),
    const MotivationalQuote(
      quote: "Just let go",
      emoji: "✨",
    ),
    const MotivationalQuote(
      quote: "The only way to do great work is to love what you do",
      emoji: "❤️",
      author: "Steve Jobs",
    ),
    const MotivationalQuote(
      quote: "Success is not final, failure is not fatal: it is the courage to continue that counts",
      emoji: "🏆",
      author: "Winston Churchill",
    ),
    const MotivationalQuote(
      quote: "The future belongs to those who believe in the beauty of their dreams",
      emoji: "🌟",
      author: "Eleanor Roosevelt",
    ),
    const MotivationalQuote(
      quote: "It does not matter how slowly you go as long as you do not stop",
      emoji: "🐢",
      author: "Confucius",
    ),
    const MotivationalQuote(
      quote: "The only impossible journey is the one you never begin",
      emoji: "🚀",
      author: "Tony Robbins",
    ),
    const MotivationalQuote(
      quote: "In the middle of difficulty lies opportunity",
      emoji: "💎",
      author: "Albert Einstein",
    ),
    const MotivationalQuote(
      quote: "The way to get started is to quit talking and begin doing",
      emoji: "🎯",
      author: "Walt Disney",
    ),
    const MotivationalQuote(
      quote: "Don't be pushed around by the fears in your mind. Be led by the dreams in your heart",
      emoji: "💭",
      author: "Roy T. Bennett",
    ),
    const MotivationalQuote(
      quote: "The only person you are destined to become is the person you decide to be",
      emoji: "👑",
      author: "Ralph Waldo Emerson",
    ),
    const MotivationalQuote(
      quote: "What lies behind us and what lies before us are tiny matters compared to what lies within us",
      emoji: "🌊",
      author: "Ralph Waldo Emerson",
    ),
    const MotivationalQuote(
      quote: "The man who moves a mountain begins by carrying away small stones",
      emoji: "⛰️",
      author: "Confucius",
    ),
    const MotivationalQuote(
      quote: "You must be the change you wish to see in the world",
      emoji: "🦋",
      author: "Mahatma Gandhi",
    ),
    const MotivationalQuote(
      quote: "The two most important days in your life are the day you are born and the day you find out why",
      emoji: "🎂",
      author: "Mark Twain",
    ),
    const MotivationalQuote(
      quote: "It is during our darkest moments that we must focus to see the light",
      emoji: "💡",
      author: "Aristotle",
    ),
    const MotivationalQuote(
      quote: "The only thing we have to fear is fear itself",
      emoji: "🛡️",
      author: "Franklin D. Roosevelt",
    ),
    const MotivationalQuote(
      quote: "I have not failed. I've just found 10,000 ways that won't work",
      emoji: "🔬",
      author: "Thomas Edison",
    ),
    const MotivationalQuote(
      quote: "Life is what happens to you while you're busy making other plans",
      emoji: "📅",
      author: "John Lennon",
    ),
    const MotivationalQuote(
      quote: "The journey of a thousand miles begins with one step",
      emoji: "👣",
      author: "Lao Tzu",
    ),
    const MotivationalQuote(
      quote: "Be yourself; everyone else is already taken",
      emoji: "🎭",
      author: "Oscar Wilde",
    ),
    const MotivationalQuote(
      quote: "Two things are infinite: the universe and human stupidity; and I'm not sure about the universe",
      emoji: "🌌",
      author: "Albert Einstein",
    ),
    const MotivationalQuote(
      quote: "So many books, so little time",
      emoji: "📖",
      author: "Frank Zappa",
    ),
    const MotivationalQuote(
      quote: "A room without books is like a body without a soul",
      emoji: "📚",
      author: "Marcus Tullius Cicero",
    ),
    const MotivationalQuote(
      quote: "You only live once, but if you do it right, once is enough",
      emoji: "🎪",
      author: "Mae West",
    ),
    const MotivationalQuote(
      quote: "Be the change that you wish to see in the world",
      emoji: "🌍",
      author: "Mahatma Gandhi",
    ),
    const MotivationalQuote(
      quote: "In three words I can sum up everything I've learned about life: it goes on",
      emoji: "🌱",
      author: "Robert Frost",
    ),
  ];

  static MotivationalQuote getRandomQuote() {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }

  static String getRandomQuoteText() {
    final quote = getRandomQuote();
    return quote.quote;
  }

  static String getRandomQuoteWithEmoji() {
    final quote = getRandomQuote();
    return '${quote.emoji} ${quote.quote}';
  }
}

