const userEndpointURL = 'https://api.twitter.com/2/users/by/username/';
const searchEndpointURL = 'https://api.twitter.com/2/tweets/search/recent';
const searchArchiveEndpointURL = 'https://api.twitter.com/2/tweets/search/all';

export async function getUserTweets(user: string, ACCESS_TOKEN: string) {
  const response = await fetch(userEndpointURL + user, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + ACCESS_TOKEN
    },
  });
  const respBody = await response.json();
	console.log('userResponse', respBody);
  return respBody
}

export async function searchTweets(params: any, ACCESS_TOKEN: string) {
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
  return respBody;
}
