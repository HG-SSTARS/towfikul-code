function charCount(data) {
    if (data) {
      return data.split('').length;
    }
  
    return 0;
  }
  
  function wordCount(data) {
    if (data) {
      return data.split(' ').length;
    }
  
    return 0;
  }
  
  let text = process.argv[2];
  
  console.log(charCount(text));
  console.log(wordCount(text));