use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

fn main(
    id: Field,
    r: Field,
    oldPath: [Field;8],
    oldRoot: pub Field,
    newRoot: pub Field,
    commitment: pub Field,
    index: pub Field,
) {
    //Checks
    let calculated_commitment: Field = pedersen_hash([id, r]);
    assert(commitment == calculated_commitment, "Invalid commitment");
    //Calculate new root and see if it matches (now with commitment at index)
    let calculated_new_root: Field = compute_merkle_root(commitment, index, oldPath);
    assert(newRoot == calculated_new_root, "Invalid new root");
    //Calculate old root and see if it matches with path
    //Use the first entry as a leaf (Assuming it's an empty leaf value)
    let EMPTY_LEAF: Field =
        0x2df8b940e5890e4e1377e05373fae69a1d754f6935e6a780b666947431f2cdcd;
    let calculated_old_root: Field = compute_merkle_root(EMPTY_LEAF, index,oldPath);
    assert(oldRoot == calculated_old_root, "Invalid old root");
}
