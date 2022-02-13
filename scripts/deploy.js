require('@nomiclabs/hardhat-waffle');

async function main() {
	const SuperMarioWorld = await ethers.getContractFactory(
		'SuperMarioWorldERC1155',
	);
	const superMarioWorld = await SuperMarioWorld.deploy(
		'SuperMarioWorldERC1155',
		'SMW1155',
	);
	await superMarioWorld.deployed();
	console.log('Success- Contract deployed at: ', superMarioWorld.address);

	await superMarioWorld.mint(
		10,
		'https://ipfs.io/ipfs/QmXiUkAf5HUDnqSL5Gu32G4cStThCgoGmhmSMMgYGXKmJd',
	);
	console.log('Success- SuperMarioWorldERC1155 minted');
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});
