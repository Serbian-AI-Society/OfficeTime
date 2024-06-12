from client import openai_client


# Function to chunk text
def chunk_text(text, chunk_size=500, overlap=50):
    words = text.split()
    chunks = []
    for i in range(0, len(words), chunk_size - overlap):
        chunk = " ".join(words[i:i + chunk_size])
        chunks.append(chunk)
    return chunks


# Function to get embeddings for text chunks
def get_embeddings_for_chunks(chunks):
    embeddings = []
    for chunk in chunks:
        embedding = get_embeddings(chunk)
        embeddings.append(embedding)
    return embeddings


def get_embeddings(text, model="text-embedding-3-small"):
    text = text.replace("\n", " ")
    return openai_client.embeddings.create(input=[text], model=model).data[0].embedding


def separate_text_from_pdf():
    # TODO
    return """
    The cat (Felis catus), commonly referred to as the domestic cat or house cat, is a small domesticated carnivorous 
    mammal. It is the only domesticated species of the family Felidae. Recent advances in archaeology and genetics 
    have shown that the domestication of the cat occurred in the Near East around 7500 BC. It is commonly kept as a 
    house pet and farm cat, but also ranges freely as a feral cat avoiding human contact. It is valued by humans for 
    companionship and its ability to kill vermin. Its retractable claws are adapted to killing small prey like mice 
    and rats. It has a strong, flexible body, quick reflexes, and sharp teeth, and its night vision and sense of 
    smell are well developed. It is a social species, but a solitary hunter and a crepuscular predator. Cat 
    communication includes vocalizations like meowing, purring, trilling, hissing, growling, and grunting as well as 
    cat body language. It can hear sounds too faint or too high in frequency for human ears, such as those made by 
    small mammals. It secretes and perceives pheromones.

Female domestic cats can have kittens from spring to late autumn in temperate zones and throughout the year in 
equatorial regions, with litter sizes often ranging from two to five kittens. Domestic cats are bred and shown at 
events as registered pedigreed cats, a hobby known as cat fancy. Animal population control of cats may be achieved by 
spaying and neutering, but their proliferation and the abandonment of pets has resulted in large numbers of feral 
cats worldwide, contributing to the extinction of bird, mammal, and reptile species.

As of 2017, the domestic cat was the second most popular pet in the United States, with 95.6 million cats owned and 
around 42 million households owning at least one cat. In the United Kingdom, 26% of adults have a cat, 
with an estimated population of 10.9 million pet cats as of 2020. As of 2021, there were an estimated 220 million 
owned and 480 million stray cats in the world.

Etymology and naming
The origin of the English word cat, Old English catt, is thought to be the Late Latin word cattus, which was first 
used at the beginning of the 6th century.[4] The Late Latin word may be derived from an unidentified African 
language.[5] The Nubian word kaddîska 'wildcat' and Nobiin kadīs are possible sources or cognates.[6]

The forms might also have derived from an ancient Germanic word that was absorbed into Latin and then into Greek, 
Syriac, and Arabic.[7] The word may be derived from Germanic and Northern European languages, and ultimately be 
borrowed from Uralic, cf. Northern Sámi gáđfi, 'female stoat', and Hungarian hölgy, 'lady, female stoat'; from 
Proto-Uralic *käďwä, 'female (of a furred animal)'.[8]

The English puss, extended as pussy and pussycat, is attested from the 16th century and may have been introduced from 
Dutch poes or from Low German puuskatte, related to Swedish kattepus, or Norwegian pus, pusekatt. Similar forms exist 
in Lithuanian puižė and Irish puisín or puiscín. The etymology of this word is unknown, but it may have arisen from a 
sound used to attract a cat.[9][10]

A male cat is called a tom or tomcat[11] (or a gib,[12] if neutered). A female is called a queen[13][14] (or 
sometimes a molly,[15] if spayed). A juvenile cat is referred to as a kitten. In Early Modern English, 
the word kitten was interchangeable with the now-obsolete word catling.[16] A group of cats can be referred to as a 
clowder or a glaring.[17]

Taxonomy
The scientific name Felis catus was proposed by Carl Linnaeus in 1758 for a domestic cat.[1][2] Felis catus 
domesticus was proposed by Johann Christian Polycarp Erxleben in 1777.[3] Felis daemon proposed by Konstantin Satunin 
in 1904 was a black cat from the Transcaucasus, later identified as a domestic cat.[18][19]

In 2003, the International Commission on Zoological Nomenclature ruled that the domestic cat is a distinct species, 
namely Felis catus.[20][21] In 2007, the modern domesticated subspecies F. silvestris catus sampled worldwide was 
considered to have likely descended from the Near Eastern wildcat (F. lybica), following results of phylogenetic 
research.[22][23][a] In 2017, the IUCN Cat Classification Taskforce followed the recommendation of the ICZN in 
regarding the domestic cat as a distinct species, Felis catus.[24]

Evolution
Main article: Cat evolution

Skulls of a wildcat (top left), a housecat (top right), and a hybrid between the two (bottom center)
The domestic cat is a member of the Felidae, a family that had a common ancestor about 10 to 15 million years ago.[
25] The evolutionary radiation of the Felidae began in Asia during the Miocene around 8.38 to 14.45 million years 
ago.[26] Analysis of mitochondrial DNA of all Felidae species indicates a radiation at 6.46 to 16.76 million years 
ago.[27] The genus Felis genetically diverged from other Felidae around 6 to 7 million years ago.[26] Results of 
phylogenetic research shows that the wild members of this genus evolved through sympatric or parapatric speciation, 
whereas the domestic cat evolved through artificial selection.[28] The domestic cat and its closest wild ancestor are 
diploid and both possess 38 chromosomes[29] and roughly 20,000 genes.[30]

Phylogenetic relationships of the domestic cat as derived through analysis of
nuclear DNA:[26][27]
 Felidae 	
Pantherinae

 Felinae 	
other Felinae lineages

 Felis 	
Jungle cat (F. chaus) 

Black-footed cat (F. nigripes)

Sand cat (F. margarita)

Chinese mountain cat (F. bieti)

African wildcat (F. lybica)

European wildcat (F. silvestris) 
    """
