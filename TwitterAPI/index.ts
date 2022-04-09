const ACCESS_TOKEN = '';


// const endpointURL = 'https://api.twitter.com/labs/2/tweets';
const userEndpointURL = 'https://api.twitter.com/2/users/by/username/';
const searchEndpointURL = 'https://api.twitter.com/2/tweets/search/recent';
const searchArchiveEndpointURL = 'https://api.twitter.com/2/tweets/search/all';

async function getUserTweets(user: string) {

  const response = await fetch(userEndpointURL + user, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + ACCESS_TOKEN
    },
  });
  const respBody = await response.json();
	console.log('userResponse', respBody);

}

// getUserTweets('FoxNews');

var yesterday = new Date('07 April 2022 14:48 UTC');

const testSearchParams = {
  query: 'Ukraine',
  end_time: yesterday.toISOString(),
  'tweet.fields': ['created_at'],
  max_results: 10
}

async function searchTweets(params: any) {
  const response = await fetch(searchEndpointURL + '?' +  new URLSearchParams(params),
    {
    method: 'GET',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + ACCESS_TOKEN
    },
  });
  const respBody = await response.json();
	console.log('userResponse', respBody);
  console.log('userResponse', respBody.data[1].text);
  return respBody;
}


async function writeToFile(object: any, filePath: string) {
  await Deno.writeTextFile(filePath, JSON.stringify(object));
  console.log('File written to ' + filePath);
}

async function saveTweetsToCSV(tweets: any, filePath: string) {
  let result: string = '';
  Object.keys(tweets.data[0]).forEach((key, index, arr) => result += key + (index != arr.length-1) ? ', ' : '');
  result += '\n';
  tweets.data.forEach((tweetData: any) => {
    Object.keys(tweetData).forEach((key, index, arr) => {
      result += tweetData[key].replace(/\n/g, "\\n") + (index != arr.length-1) ? ', ' : '';
    })
    result += '\n';
  });
  await Deno.writeTextFile(filePath, result);
}


async function main() {
  // const tweets = await searchTweets(testSearchParams);
  const tweets = {
    data: [
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079749132152845",
        text: "RT @mariamposts: Is Ukraine an ideal country without racism? \nNo.\n\nDoes the Ukrainian far-right have..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079748813320210",
        text: "While bombs are raining down on the civilian population in Tigray, the outcry is huge when Ukraine i..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079748649799693",
        text: "RT @anders_aslund: Clearly, Putin wants to seize the whole of Donetsk and Luhansk oblasts. There, th..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079748578496525",
        text: "RT @antiwar_soldier: The same weapon was previously used by Ukraine in attacks on Donbass (image att..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079747806728197",
        text: "RT @BTnewsroom: For those who just discovered Ukraine 2 months ago, the idea that Ukrainian national..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079747685048338",
        text: "RT @Sho_Tam_: 💰Чехія випустила колекційну банкноту під назвою Sláva Ukraine.\n\nНова банкнота з тираж..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079747546640405",
        text: "@RishiSunak @JamesCleverly @BorisJohnson I may be wrong but I feel this is aimed at you C***s #Johns..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079747488317442",
        text: "RT @enhypenupdates: UKRAINE NEEDS YOUR VOICE 🇺🇦🌻\n\nWe are calling for your attention to be informe..."
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079747206942724",
        text: 'RT @Anwalt_Jun: Natürlich kann man gegen russlandfeindliches Verhalten demonstrieren. Wer aber die "...'
      },
      {
        created_at: "2022-04-07T14:47:59.000Z",
        id: "1512079747039522816",
        text: "#Zelenskyy is likely to declare #Ukraine’e victory over #Russia as soon as in the next 10 days.\n\nWha..."
      }
    ],
    meta: {
      newest_id: "1512079749132152845",
      oldest_id: "1512079747039522816",
      result_count: 10,
      next_token: "b26v89c19zqg8o3fpytlutjrvws9l7th1uu49lyumdqpp"
    }
  };
  await saveTweetsToCSV(tweets, './test.csv');
}

main();