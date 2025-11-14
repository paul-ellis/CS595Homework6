use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

fn main(
    r: Field,
    index: Field,
    hashpath: [Field;8], //Depth?
    root: pub Field,
    id: pub Field,
) {
    //Calculate root with leaf perdenson hash(id, r) at index
    let commitment: Field = pedersen_hash([id, r]);
    let calculated_root: Field = compute_merkle_root(commitment, index, hashpath);
    assert(root == calculated_root, "Invalid root");
}
