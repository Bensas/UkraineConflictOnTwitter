export async function writeToFile(object: any, filePath: string) {
  await Deno.writeTextFile(filePath, JSON.stringify(object));
  console.log('File written to ' + filePath);
}

export async function saveTweetsToCSV(tweets: any, filePath: string) {
  let result: string = '';
  Object.keys(tweets.data[0]).forEach((key, index, arr) => result += key + ((index != arr.length-1) ? ', ' : ''));
  result += '\n';
  tweets.data.forEach((tweetData: any) => {
    Object.keys(tweetData).forEach((key, index, arr) => {
      result += tweetData[key].replace(/\n/g, "\\n") + ((index != arr.length-1) ? ', ' : '');
    })
    result += '\n';
  });
  await Deno.writeTextFile(filePath, result);
}
