function myFunction() {
    document.getElementById('demo').innerHTML="I'm a paragraph";
}

function windowAlert() {
    alert('You clicked blue button');
}

function findPower(num){
    alert('Value of number to the power number is ' + num**num);
}

const person = {
    firstName: 'Naman',
    lastName: 'Dua',
    id: 69,

    fullName: function() {
        return this.firstName+' '+this.lastName;
    }
};

document.getElementById("rand").innerHTML = Math.floor(Math.random() * 101);

const date = new Date();
document.getElementById("date").innerHTML = date;