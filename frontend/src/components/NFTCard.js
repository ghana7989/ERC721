import React from 'react';
import styled from 'styled-components';

const StyledNFTCard = styled.div`
	width: 200px;
	height: 200px;
	margin: auto;
	border-radius: 10px;
	padding: 0px;
	cursor: pointer;
	box-shadow: 0px 0px 10px 0px rgba(0, 34, 0, 0.75);
`;
const StyledNFTCardImage = styled.div`
	display: block;
	width: 200px;
	height: 200px;
	background-position: center center;
	background-size: cover;
	margin: auto;
	border-radius: 10px;
`;

export default function NFTCard({nft}) {
	return (
		<StyledNFTCard>
			<StyledNFTCardImage
				style={{
					backgroundImage: `url(${
						nft?.image || 'https://via.placeholder.com/200x200'
					})`,
				}}
			/>
		</StyledNFTCard>
	);
}
