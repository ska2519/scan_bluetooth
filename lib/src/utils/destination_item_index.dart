int getItemIndex(int kAdIndex, int rawIndex) {
  const adCount = 1;
  // final adCount = rawIndex ~/ kAdIndex;
  return rawIndex > kAdIndex ? rawIndex - adCount : rawIndex;
}
