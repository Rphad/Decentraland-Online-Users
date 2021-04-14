const fetch = require('node-fetch');

// This defines the properties of the csv file.
// More info here : https://www.npmjs.com/package/csv-writer
const createCsvWriter = require('csv-writer').createObjectCsvWriter;
const csvWriter = createCsvWriter({
    path: './activity_history.csv',
    header: [
        {id: 'time', title: 'TIME'},
        {id: 'players', title: 'PLAYERS'}
    ],
    append: true,
});

// Decentraland nodes. I got the list from https://catalyst-monitor.vercel.app/
const productiveServers = [
	'https://peer.decentraland.org',           // DCL
	'https://peer-ec1.decentraland.org',       // DCL - US East
	'https://peer-wc1.decentraland.org',       // DCL - US West
	'https://peer-eu1.decentraland.org',       // DCL - EU
	'https://peer-ap1.decentraland.org',
	'https://interconnected.online',           // Esteban
	'https://peer.decentral.games',            // Baus
	'https://peer.melonwave.com',              // Ari
	'https://decentraland.org.cn',             // JJ
	'https://peer.kyllian.me',                 // Kyllian
	'https://peer.uadevops.com',               // SFox
	'https://peer.dclnodes.io',                // DSM
]

// This function queries each node for its online users and add them to the total.
// It is recursive :)
async function getUsers(hosts, index) {
  console.log(hosts[index])
  fetch(hosts[index]+'/comms/layers').then(_ => {
	  return _.json()
	}).then(_ => {
    if (index < hosts.length - 1) {
      tot+=_.reduce((sum, elem) => sum + elem.usersCount, 0);
      getUsers(hosts, index+1)
    } else {
      newEntry = [{time: Date.now(),  players: tot}]
      console.log(newEntry)
      console.log("Got the total")
      csvWriter.writeRecords(newEntry).then(() => {
				console.log('Wrote to the csv. \n Done.');
			});
    }
  })
}

// Let's go
var tot = 0;
getUsers(productiveServers, 0)
