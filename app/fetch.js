// AJOUTER DES PHOTOS à L'ANNONCE (l'annonce doit être créée en base avant l'upload des photos):
const [images, setImages] = useState({})
  const handleOnChange = (e) => {
    setImages(e.target.files)
  }

const handleSubmit = (files, listing) => {
  for (let index in files){
    if(index.length === 1){
      let upload = new DirectUpload(files[index], `${url}/rails/active_storage/direct_uploads`)
      upload.create( (error,blob)=>{
              if(error){
                console.log(error)
              }else{
                fetch(`https://thp-immo-api.herokuapp.com/posts/${listing.id}`, {
                        method: 'PUT',
                        headers: {
                          'Authorization': "TOKEN",
                          'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({listing: listing, images: blob.signed_id })
                })
              }
            })
          }
      }
    }
// FORMULAIRE UPLOAD 
      <form onSubmit={handleSubmit}>  
        <input type="file" name="images"  onChange={handleOnChange} multiple/>
        <input type="submit" value="Publier images" />
      </form>