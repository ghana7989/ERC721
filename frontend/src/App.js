import NFTCard from './components/NFTCard';

const nfts = [
	{
		name: 'Mario',
		symbol: 'M',
		copies: 10,
		image:
			'https://www.giantbomb.com/a/uploads/square_medium/15/153607/3340831-mario.jpg',
	},
	{
		name: 'Mario',
		symbol: 'M',
		copies: 10,
		image:
			'https://www.giantbomb.com/a/uploads/square_medium/15/153607/3340831-mario.jpg',
	},
	{
		name: 'Mario',
		symbol: 'M',
		copies: 10,
		image:
			'https://www.giantbomb.com/a/uploads/square_medium/15/153607/3340831-mario.jpg',
	},
	{
		name: 'Mario',
		symbol: 'M',
		copies: 10,
		image:
			'https://www.giantbomb.com/a/uploads/square_medium/15/153607/3340831-mario.jpg',
	},
	{
		name: 'Mario',
		symbol: 'M',
		copies: 10,
		image:
			'https://www.giantbomb.com/a/uploads/square_medium/15/153607/3340831-mario.jpg',
	},
];
function App() {
	return (
		<div className='App'>
      {nfts.map((nft, i) => (
				<div key={i}>
					<NFTCard nft={nft} />
				</div>
			))}
		</div>
	);
}

export default App;
