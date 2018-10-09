pragma solidity 0.4.24;

import "./libraries/LTVDecisionEngineTypes.sol";


contract LTVDecisionEngine {
	bytes constant internal COMMITMENT_HASH_PREFIX = "\x19Ethereum Signed Message:\n32";

	function evaluateConsent(
		LTVDecisionEngineTypes.Params params
	)
	public view returns (bool signatureValid, bytes32 _id)
	{
		// Access the commitment values from the given args.
		LTVDecisionEngineTypes.CommitmentValues commitmentValues = params.commitmentValues;

		// Create a hash of the commitment values.
		bytes32 commitmentHash = keccak256(
			commitmentValues.creditor,
			commitmentValues.repaymentRouter,
			commitmentValues.creditorFee,
			commitmentValues.underwriter,
			commitmentValues.underwriterRiskRating,
			commitmentValues.termsContract,
			commitmentValues.termsContractParameters,
			commitmentValues.commitmentExpirationTimestampInSec,
			commitmentValues.salt
		);

		return SignaturesLibrary.isValidSignature(
			params.creditor,
			COMMITMENT_HASH_PREFIX,
			commitmentHash,
			params.creditorSignature
		);
	}

	function evaluateDecision(
		LTVDecisionEngineTypes.Params params
	)
	public view returns (bool _success)
	{
		// The CreditorProxyDecisionEngine is naive, and simply returns true.
		return true;
	}
}
