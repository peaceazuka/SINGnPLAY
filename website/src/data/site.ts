// ---------------------------------------------------------------------------
// All the words and numbers on the site live here. Edit this file to change
// copy anywhere on the page — no component/layout code needs to change.
//
// Anything wrapped as `"PLACEHOLDER: ..."` is a stand-in and should be
// replaced with the real thing (a testimonial, a price, a store link)
// before launch.
// ---------------------------------------------------------------------------

export const brand = {
  name: "SINGnPLAY",
  productName: "SINGnPLAY WorshipTime",
  tagline: "Learn worship songs together, as a family.",
};

export const storeBadges = {
  appStoreUrl: "PLACEHOLDER: https://apps.apple.com/app/idXXXXXXXXX",
  playStoreUrl: "PLACEHOLDER: https://play.google.com/store/apps/details?id=com.singnplay.worshiptime",
};

export const hero = {
  eyebrow: "For families who love to sing",
  heading: "Worship songs the whole family learns together",
  subheading:
    "Every Mom, Dad, and kid gets their own profile, their own songs, and their own streak. Simply Piano-style step-by-step lessons, built for hymns, worship songs, and scripture songs.",
  ctaLabel: "Start free",
};

export const familyProfiles = [
  { id: "mom", name: "Mom", emoji: "👩", colorHex: "#FF6B9D" },
  { id: "dad", name: "Dad", emoji: "👨", colorHex: "#4ECDC4" },
  { id: "noah", name: "Noah", emoji: "🧒", colorHex: "#FFC857" },
  { id: "ava", name: "Ava", emoji: "👧", colorHex: "#5B3DF5" },
];

export const categories = [
  { title: "Worship Songs", emoji: "⛪", colorHex: "#5B3DF5" },
  { title: "Kids & Rhymes", emoji: "🧸", colorHex: "#FF6B9D" },
  { title: "Classic Hymns", emoji: "📖", colorHex: "#4ECDC4" },
  { title: "Scripture Songs", emoji: "📜", colorHex: "#FFA726" },
  { title: "Christmas", emoji: "⭐", colorHex: "#E5525A" },
  { title: "Just for Fun", emoji: "🎉", colorHex: "#FFC857" },
];

export const featuredSongs = [
  { title: "This Little Light of Mine", subtitle: "Kids & Rhymes", duration: "4 min", difficulty: 1 },
  { title: "Amazing Grace", subtitle: "Classic Hymns", duration: "6 min", difficulty: 2 },
  { title: "Jesus Loves Me", subtitle: "Scripture Songs", duration: "3 min", difficulty: 1 },
  { title: "Oh Happy Day", subtitle: "Worship Songs", duration: "7 min", difficulty: 3 },
];

export const howItWorks = [
  {
    step: "1",
    title: "Pick a profile",
    description: "Every family member gets their own space — Mom, Dad, and every kid, each with their own progress.",
  },
  {
    step: "2",
    title: "Choose a song",
    description: "Browse worship songs, hymns, scripture songs, and kids' favorites, sorted by difficulty and length.",
  },
  {
    step: "3",
    title: "Sing & play together",
    description: "Follow along step by step, build a daily streak, and take on today's challenge as a family.",
  },
];

export const gamification = {
  heading: "Practice sticks when it feels like play",
  stats: [
    { label: "Day streak", value: "12" },
    { label: "Songs learned", value: "28" },
    { label: "Minutes today", value: "15" },
  ],
  challengeTitle: "Today's Challenge",
  challengeDescription: "Learn 'Jesus Loves Me' in 10 minutes and earn a gold star!",
};

// TODO: replace with real families/churches using the app.
export const testimonials = [
  {
    quote: "PLACEHOLDER: \"Our kids ask to do their worship practice now instead of us asking them.\"",
    name: "PLACEHOLDER: The Johnson Family",
  },
  {
    quote: "PLACEHOLDER: \"Finally something the whole family can learn together, not just the kids.\"",
    name: "PLACEHOLDER: Pastor A. Reyes, Grace Community Church",
  },
  {
    quote: "PLACEHOLDER: \"The streaks and challenges got my teenager actually excited about hymns.\"",
    name: "PLACEHOLDER: The Okafor Family",
  },
];

// TODO: replace with real plans and prices.
export const pricing = {
  heading: "Simple pricing for the whole family",
  plans: [
    {
      name: "Free",
      price: "$0",
      period: "forever",
      description: "PLACEHOLDER: Get started with a limited song library and one profile.",
      cta: "Start free",
      featured: false,
    },
    {
      name: "Family",
      price: "PLACEHOLDER: $9.99",
      period: "/month",
      description: "PLACEHOLDER: Unlimited songs, unlimited profiles, streaks, and challenges for the whole family.",
      cta: "Start free trial",
      featured: true,
    },
    {
      name: "Annual",
      price: "PLACEHOLDER: $79",
      period: "/year",
      description: "PLACEHOLDER: Everything in Family, billed once a year and save.",
      cta: "Start free trial",
      featured: false,
    },
  ],
};

export const faq = [
  {
    question: "What ages is SINGnPLAY for?",
    answer:
      "PLACEHOLDER: SINGnPLAY is built for the whole family — lessons range from simple kids' songs to more advanced hymns and worship songs for adults.",
  },
  {
    question: "Do I need an instrument?",
    answer:
      "PLACEHOLDER: No instrument is required to sing along, though the app can also guide piano/keyboard practice for songs that support it.",
  },
  {
    question: "Is SINGnPLAY tied to a specific denomination?",
    answer:
      "PLACEHOLDER: SINGnPLAY's song library spans classic hymns, scripture songs, and general worship music meant to be welcoming across Christian traditions.",
  },
  {
    question: "Can I use it offline?",
    answer:
      "PLACEHOLDER: Downloaded songs are available offline; browsing the full library requires an internet connection.",
  },
  {
    question: "How many family members can share one account?",
    answer:
      "PLACEHOLDER: The Family plan supports unlimited profiles, so everyone in the house can have their own progress and streak.",
  },
];

export const footer = {
  links: [
    { label: "About", href: "#" },
    { label: "Pricing", href: "#pricing" },
    { label: "FAQ", href: "#faq" },
    { label: "Contact", href: "PLACEHOLDER: mailto:hello@singnplay.com" },
  ],
};
