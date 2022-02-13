require('@nomiclabs/hardhat-waffle');

async function main() {
	const SuperMarioWorld = await ethers.getContractFactory('SuperMarioWorld');
	const superMarioWorld = await SuperMarioWorld.deploy(
		'SuperMarioWorld',
		'SMW',
	);
	await superMarioWorld.deployed();
	console.log('Success- Contract deployed at: ', superMarioWorld.address);

	await superMarioWorld.mint(
		'https://ipfs.io/ipfs/QmeMxxQwqM7jFW1YHUQNPR2VjSsQLJjerKFnABNUMG7XVt',
	);
	console.log('Success- SuperMarioWorld minted');
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});
